  # Этап 1: Сборка приложения
  FROM golang:1.20 AS builder
  WORKDIR /app
  COPY . .
  RUN go mod download
  RUN CGO_ENABLED=0 GOOS=linux go build -o main .

  # Этап 2: Запуск из минимального образа
  FROM alpine:latest
  WORKDIR /app
  COPY --from=builder /app/main .
  CMD ["./main"]