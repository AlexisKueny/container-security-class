FROM alpine:latest

RUN adduser -D -u 1001 appuser

# No fixed CMD — each demo script supplies its own command via docker run.
CMD ["/bin/sh"]