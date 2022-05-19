#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS debug
# install remote debugger
RUN apt update && \
    apt install -y curl unzip && \
    curl -sSL https://aka.ms/getvsdbgsh | /bin/sh /dev/stdin -v latest -l /vsdbg

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
RUN apt update && \
    apt install -y procps
WORKDIR /app
EXPOSE 80
EXPOSE 11111
EXPOSE 30000

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["API/API.csproj", "API/"]
COPY ["Orleans.Azure.Infrastructure/Orleans.Azure.Infrastructure.csproj", "Orleans.Azure.Infrastructure/"]
COPY ["Abstractions/Abstractions.csproj", "Abstractions/"]
COPY ["Grains/Grains.csproj", "Grains/"]
COPY ["Infrastructure/Infrastructure.csproj", "Infrastructure/"]
RUN dotnet restore "API/API.csproj"
COPY . .
WORKDIR "/src/API"
RUN dotnet build "API.csproj" -c Debug -o /app/build

FROM build AS publish
RUN dotnet publish "API.csproj" -c Debug -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY --from=debug /vsdbg /vsdbg
ENTRYPOINT ["dotnet", "API.dll"]