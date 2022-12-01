FROM ruby:3.1

ARG RUBYGEMS_VERSION=3.3.20

# RUN：任意のコマンド実行
RUN mkdir /app

# WORKDIR：作業ディレクトリを指定
WORKDIR /app

# COPY：コピー元とコピー先を指定
# ローカルのGemfileをコンテナ内の/app/Gemfileに
COPY Gemfile /app/Gemfile

COPY Gemfile.lock /app/Gemfile.lock

# RubyGemsをアップデート
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install

COPY . /app

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

# CMD:コンテナ実行時、デフォルトで実行したいコマンド
# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]
