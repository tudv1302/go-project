package sports_store

import (
	"github.com/gin-gonic/gin"
	"log"
	"sports-store/database"
	"sports-store/routes"
)

func main() {
	database.ConnectDatabase()

	r := gin.Default()
	routes.RegisterRoutes(r)

	log.Println("Server đang chạy tại cổng 8080...")
	r.Run(":8080")
}
