FROM microsoft/dotnet:sdk AS build-env

MAINTAINER acmodeu <acmodeu@gmail.com>

WORKDIR /app

# Copy csproj and restore as distinct layers
RUN git clone https://github.com/kaanlab/TestWebApp.git .
#COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
#COPY . ./

RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .

#ENTRYPOINT ["dotnet", "aspnetapp.dll"]
ENTRYPOINT [ "/bin/sh" ]
