.PHONY: help proto-gen proto-clean

MODULE := $(shell go list -m)

help:
	@echo "Available commands:"
	@echo "  proto-gen   - Generate protobuf code"
	@echo "  proto-clean - Clean generated files"

proto-gen:
	@echo "Generating protobuf code..."
	@echo "Module: $(MODULE)"
	protoc -I proto --go_out=. --go_opt=module=$(MODULE) proto/user/user.proto
	@echo "Generated successfully!"

proto-clean:
	@echo "Cleaning generated files..."
	find ./internal/gen -name "*.pb.go" -delete 2>/dev/null || true
	@echo "Cleaned!"
