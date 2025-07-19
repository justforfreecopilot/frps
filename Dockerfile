FROM alpine:latest

# Install curl and tar
RUN apk add --no-cache curl tar

# Download and extract frp release (server only)
RUN curl -L -o /tmp/frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.58.0/frp_0.58.0_linux_amd64.tar.gz \
    && mkdir -p /frp \
    && tar -xzf /tmp/frp.tar.gz -C /frp --strip-components=1 \
    && rm /tmp/frp.tar.gz

# Copy your config
COPY frps.ini /frp/frps.ini

# Set working directory
WORKDIR /frp

# Expose necessary ports (adjust as needed)
EXPOSE 7000/tcp
EXPOSE 7500/tcp

# Start frps
CMD ["./frps", "-c", "frps.ini"]
