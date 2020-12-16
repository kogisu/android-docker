FROM openjdk:8

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN apt update -y && apt install -y vim \
	&& curl -L -o /tmp/gradle-6.7.1-bin.zip https://services.gradle.org/distributions/gradle-6.7.1-bin.zip \
	&& mkdir -p /opt/gradle \
	&& unzip -d /opt/gradle /tmp/gradle-6.7.1-bin.zip

ENV PATH="${PATH}:/opt/gradle/gradle-6.7.1/bin"

ENV ANDROID_SDK_ROOT=/usr/src/.android
ENV ANDROID_API_VERSION="28"

WORKDIR ${ANDROID_SDK_ROOT}/cmdline-tools

RUN curl -L -o /tmp/clt.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
	&& unzip -d /tmp/tools /tmp/clt.zip \
	&& mv /tmp/tools/cmdline-tools /tmp/tools/tools \
	&& mv /tmp/tools/tools ${ANDROID_SDK_ROOT}/cmdline-tools

ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin

RUN sdkmanager "platform-tools" "platforms;android-${ANDROID_API_VERSION}"

