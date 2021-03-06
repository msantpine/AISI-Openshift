FROM node:10

ARG GROUP=1000
ARG USER=1000
ARG S2IDIR="/home/s2i"
ARG APPDIR="/src/app"
ARG TESTDIR="/src/app/tests"

LABEL io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,nodejs" \
      io.openshift.s2i.scripts-url="image://$S2IDIR/bin"

COPY s2i ${S2IDIR}
RUN chmod 777 -R ${S2IDIR}

COPY src/package.json ${APPDIR}/package.json
COPY src/tests/. ${TESTDIR}

RUN groupadd ${GROUP} \
    && useradd -g ${GROUP} ${USER} \
    && chmod a+rwx -R ${APPDIR} 
    

WORKDIR ${APPDIR}

EXPOSE 8080

USER ${USER}

CMD [ "${S2IDIR}/bin/run" ]