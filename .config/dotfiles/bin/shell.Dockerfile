FROM debian:bookworm-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates git yadm zsh \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .
ENTRYPOINT ["/src/.config/dotfiles/bin/shell-init"]
