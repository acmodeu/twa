#FROM microsoft/dotnet:sdk AS build-env
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env

MAINTAINER acmodeu <acmodeu@gmail.com>

WORKDIR /app

# Copy csproj and restore as distinct layers
RUN git clone -b '0.0.2-alfa' https://github.com/kaanlab/PetrpkuWeb.git .
#COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
#COPY . ./

RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "TestWebApp.dll"]
#ENTRYPOINT [ "/bin/sh" ]
