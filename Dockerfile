FROM jekyll/builder AS builder

WORKDIR /var/jekyll
COPY Gemfile Gemfile.lock ./
# https://github.com/instructure/canvas-lms/issues/1221#issuecomment-362690811
RUN chmod a+w ./Gemfile.lock && bundle install
COPY . .
ENV JEKYLL_ENV=production
RUN chmod a+w ./Gemfile.lock && jekyll build

FROM nginx:alpine AS serv

COPY --from=builder /var/jekyll/_site /usr/share/nginx/html
COPY --from=builder /var/jekyll/docker_ssl_proxy /etc/nginx/conf.d