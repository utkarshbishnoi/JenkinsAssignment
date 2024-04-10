FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS builder

COPY . .

WORKDIR /WebApp

RUN dotnet restore

RUN dotnet publish Web/Web.csproj -c Release -o /app

RUN dotnet test --logger "trx;LogFileName=./Web.trx"

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

COPY --from=builder /app .

ENTRYPOINT ["dotnet", "Web.dll"]
