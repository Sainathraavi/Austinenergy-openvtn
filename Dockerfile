from openjdk:8-jre
ARG VTN_BUILD_TAG

RUN adduser --gecos GECOS openadr -disabled-login

ENV tarfile oadr2b-vtn-0.9.3.production-${VTN_BUILD_TAG}.tar.gz
ENV RUBYLIB=/oadr
RUN mkdir $RUBYLIB
COPY $tarfile $RUBYLIB/$tarfile
WORKDIR $RUBYLIB


RUN tar xvf ${tarfile} \
&& rm ${tarfile}  \
&& apt-get update  \
&& apt-get install -y apt-utils  \
&& apt-get install -y  htop nano \
&& apt-get install -y mysql-client \
&& chown -R openadr:openadr .


WORKDIR /

COPY jruby-bin-9.1.5.0.tar.gz /jruby-bin-9.1.5.0.tar.gz
RUN tar xvf /jruby-bin-9.1.5.0.tar.gz \
&& rm /jruby-bin-9.1.5.0.tar.gz \
&& chown -R openadr:openadr /jruby-9.1.5.0/
ENV PATH /jruby-9.1.5.0/bin:$PATH


COPY database.yml $RUBYLIB/config/database.yml
COPY secret_token.rb.example $RUBYLIB/config/initializers/secret_token.rb

USER openadr
ENV PATH ${JRUBY_HOME}/bin:$PATH
WORKDIR $RUBYLIB
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true

RUN gem install bundler \
&& bundler install --clean --retry=5 
#&& rake assets:clean \
#&& rake assets:precompile \
#&& rake routes \
#&& ln -s /dev/null ${HOME}/.mysql_history

EXPOSE 65234

ENV JAVA_OPTS -Xmx512M
ENV DATABASE_URL jdbc:mysql://address=(protocol=tcp)(host=myhost)(port=3306)(user=myuser)(password=mypassword)/mydatabase
ENV DATABASE_POOL 20
ENV BIND_ADDRESS 0.0.0.0
ENV PORT 65234

ADD run.sh /run.sh
CMD ["/run.sh"]
