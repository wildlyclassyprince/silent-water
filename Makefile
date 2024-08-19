IMAGE_NAME := "silent-water"
CONTAINER_NAME := "silent-water"

init:
	@./init.sh $(IMAGE_NAME) $(CONTAINER_NAME)

clean:
	@./cleanup.sh $(CONTAINER_NAME)
