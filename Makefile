.PHONY: help proto-gen proto-clean install-tools proto-user proto-monitor

MODULE := $(shell go list -m)

help:
	@echo "Available commands:"
	@echo "  proto-gen     - Generate all protobuf code"
	@echo "  proto-user    - Generate user protobuf code"
	@echo "  proto-monitor - Generate monitor protobuf code"
	@echo "  proto-clean   - Clean generated files"
	@echo "  install-tools - Install required tools"

install-tools:
	@echo "Installing tools..."
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@echo "Tools installed!"

proto-gen: proto-user proto-monitor
	@echo "All protobuf code generated!"

proto-user:
	@echo "Generating user protobuf code..."
	@echo "Module: $(MODULE)"
	protoc -I proto \
		--go_out=. --go_opt=module=$(MODULE) \
		proto/user/user.proto
	@echo "User protobuf generated!"

proto-monitor:
	@echo "Generating monitor protobuf code..."
	@echo "Module: $(MODULE)"
	protoc -I proto \
		--go_out=. --go_opt=module=$(MODULE) \
		proto/monitor/monitor.proto
	@echo "Monitor protobuf generated!"

proto-clean:
	@echo "Cleaning generated files..."
	@if command -v find >/dev/null 2>&1; then \
		find ./internal/gen -name "*.pb.go" -delete 2>/dev/null || true; \
	else \
		powershell -NoLogo -NoProfile -Command "Get-ChildItem -Recurse -Filter *.pb.go -Path internal/gen | Remove-Item -Force -ErrorAction SilentlyContinue"; \
	fi
	@echo "Cleaned!"