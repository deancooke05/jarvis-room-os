# Security and privacy policy

## Never publish

Do not commit any of the following:

- Home Assistant long-lived access tokens or API keys.
- `.env` files.
- LM Studio, OpenAI, Telegram, email, or other credentials.
- Camera captures, face samples, visual-memory images, room layouts, or addresses.
- Logs, backups, telemetry, screenshots containing credentials, internal IP addresses, serial numbers, or private messages.
- Live `config` and `data` directories from the production machine.

## Before every push

1. Run `python scripts/verify_public_repo.py`.
2. Check `git status` and read every file about to be committed.
3. Confirm screenshots are cropped and do not expose sensitive data.
4. Use only files from `config_examples/` in the public repository.

## If a secret is committed

1. Revoke or rotate it immediately.
2. Remove it from the repository history, not only the latest file version.
3. Treat the old value as compromised.

This is a personal portfolio project, not a production security product.
