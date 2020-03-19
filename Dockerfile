FROM ruby:2.5
MAINTAINER Chef Software, Inc. <docker@chef.io>

ARG TF_VERSION=0.12.3

ENV AWS_REGION us-east-1
ENV CHEF_LICENSE="accept-silent"

ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip .
ADD sample_profile /inspec/sample_profile

COPY Gemfile .
RUN bundle install \
    && gem list && apt-get update \
    && apt-get install unzip \
    && unzip terraform_${TF_VERSION}_linux_amd64.zip && mv terraform /usr/local/bin/ \
    && rm terraform_${TF_VERSION}_linux_amd64.zip \
    && apt-get clean \
    && bundle update \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /inspec

