FROM alpine:3.21


RUN apk add --no-cache \
    typst git cargo

# /root/.cargo/bin

RUN echo -e "\
export PATH=\$PATH:$HOME/.cargo/bin \n\
" >> ~/.rc

ENV ENV=/root/.rc