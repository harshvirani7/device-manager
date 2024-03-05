FROM golang:1.22.0-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /my-app

FROM gcr.io/distroless/base-debian11

COPY --from=build /my-app /my-app

ENTRYPOINT ["/my-app"]
