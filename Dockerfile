FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder

RUN apk add --no-cache \
    neovim \
    git \
    build-base \
    curl \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /root/.config/nvim

COPY init.lua /root/.config/nvim/init.lua
COPY lazy-lock.json /root/.config/nvim/lazy-lock.json
COPY snippets.lua /root/.config/nvim/lua/snippets.lua
COPY lua/ /root/.config/nvim/lua/
COPY colors/ /root/.config/nvim/colors/
COPY spell/ /root/.config/nvim/spell/

RUN nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

# Build native extensions
RUN cd /root/.local/share/nvim/lazy/telescope-fzf-native.nvim && \
    make 2>/dev/null || true

RUN cd /root/.local/share/nvim/lazy/LuaSnip && \
    make install_jsregexp 2>/dev/null || true

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS runner

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache \
    neovim \
    git \
    ripgrep \
    && rm -rf /var/cache/apk/*

COPY --from=builder /root/.config/nvim /root/.config/nvim
COPY --from=builder /root/.local/share/nvim /root/.local/share/nvim

WORKDIR /workspace
ENTRYPOINT ["nvim"]
