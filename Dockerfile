FROM nginx
COPY target/teavm.test-1.0-SNAPSHOT/static /usr/share/nginx/html
COPY target/teavm.test-1.0-SNAPSHOT/teavm-wasm /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80