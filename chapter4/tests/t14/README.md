# OMM Container

The test task demonstrates Docker container OOM feature in action.

## How To Use

1. Make sure the system has Docker installed.
2. Run `make build`.
3. Run `make run`.

## Makefile Commands

- `build`. Creates new Docker image. Image tag is `krasninja/python-oom:0.1.0`. If an image with the same tag exists it will be removed.
- `run`. Run the container. Parameters:
    - `LIMIT`. Specifies container memory limit. Default is 100m.

## Examples

- `make LIMIT=30m run`. Runs the container with memory limit 30 MB.

## Links

- Test task: https://github.com/saritasa-nest/saritasa-devops-camp/blob/main/chapter4%20-%20containers/l1/introduction.md#tasks-for-today
- pre-commit: https://pre-commit.com/
