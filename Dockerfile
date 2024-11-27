# Sử dụng image chính thức Go
FROM golang:1.23 AS builder

# Tạo thư mục làm việc
WORKDIR /app

# Sao chép go.mod và go.sum
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Cài đặt các dependencies
RUN go mod tidy


# Sao chép mã nguồn vào trong container
COPY . .

# Biên dịch ứng dụng Go
RUN go build -o main .

# Sử dụng image nhỏ hơn để chạy ứng dụng
FROM alpine:latest

# Set the Current Working Directory inside the container
WORKDIR /root/

# Cài đặt các phụ thuộc cần thiết
RUN apk add --no-cache libc6-compat

# Sao chép tệp thực thi từ builder
COPY --from=builder /app/main .

# Mở cổng cho ứng dụng
EXPOSE 8080

# Chạy ứng dụng Go
CMD ["/main"]
