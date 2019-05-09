FROM node:10

ARG GROUP=1000
ARG USER=1000
ARG S2IDIR="/home/s2i"
ARG APPDIR="/src/app"

COPY s2i ${S2IDIR}
RUN chmod 777 -R ${S2IDIR}

COPY src/* ${APPDIR}}

# Add user & group
RUN groupadd ${GROUP}} \
    && useradd -g ${GROUP}} ${USER} \
    && chown -R ${USER}:${GROUP}} ${APPDIR} \
    && chmod +x ${APPDIR}/index.js

WORKDIR ${APPDIR}

EXPOSE 8080

USER ${USER}

CMD [ "${S2IDIR}/bin/run" ]