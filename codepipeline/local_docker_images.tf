locals {
  codebuild_docker_images = {
    ubuntu = "aws/codebuild/standard:2.0"
    docker = "aws/codebuild/docker:18"
    golang = "aws/codebuild/golang:1.12"
    nodejs = "aws/codebuild/nodejs:10"
    python = "aws/codebuild/python:3.7"
    java   = "aws/codebuild/java:openjdk11"
    ruby   = "aws/codebuild/ruby:2.6"
  }
}
