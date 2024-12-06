FROM debian:bullseye-slim AS build

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Configure Flutter
RUN flutter channel stable && \
    flutter upgrade && \
    flutter config --enable-web

WORKDIR /app
COPY . .

# Update web icons with Android icons
RUN cp android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png web/favicon.png && \
    convert android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png -resize 192x192 web/icons/Icon-192.png && \
    convert android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png -resize 192x192 web/icons/Icon-maskable-192.png && \
    convert android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png -resize 512x512 web/icons/Icon-512.png && \
    convert android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png -resize 512x512 web/icons/Icon-maskable-512.png

# Get Flutter dependencies and build for web
RUN flutter pub get && \
    flutter build web

# Production stage
FROM nginx:alpine

# Copy the built web files to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Configure nginx to handle Flutter web routing
RUN echo 'server { \
    listen 8080; \
    location / { \
        root /usr/share/nginx/html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
