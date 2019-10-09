#FROM microsoft/dotnet:sdk AS build-env
#FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
MAINTAINER acmodeu <acmodeu@gmail.com>

WORKDIR /app

#RUN git config --global user.name "acmodeu"
#RUN git config --global user.email "acmodeu@gmail.com"

# Copy csproj and restore as distinct layers
RUN git clone --single-branch -b '0.0.2-alfa' https://github.com/kaanlab/PetrpkuWeb.git .
#COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
#COPY . ./

RUN dotnet publish -c Release -o out

# Build runtime image
#FROM microsoft/dotnet:aspnetcore-runtime
FROM mcr.microsoft.com/dotnet/core/runtime:3.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "PetrpkuWeb.dll"]
#ENTRYPOINT [ "/bin/sh" ]
