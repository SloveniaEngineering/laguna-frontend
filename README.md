# laguna

## Setup

1. Clone this repo, `cd` into it, run generators. 
2. Run [laguna-backend](https://github.com/SloveniaEngineering/laguna-backend) with `scripts/dev.sh`
3. Run this app with `--web-port=4200` (same as `FRONTEND_PORT` in `scripts/dev.sh`) so that FE gets whitelisted as origin by CORS.
4. Possible workarounds for (3): `--web-browser-flag "--disable-web-security"`. (**DO NOT USE IN PRODUCTION**).