FROM golang:1.18

# Set the working directory
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

# Copy current directory to /app
COPY . .

# Build
RUN go build -o main .

# ENV DEMO_APP_ADDR=:8080
# ENV DEMO_REDIS_ADDR=redis:6379

EXPOSE 8080

# Run
CMD ["./main"]