# ICPress Platform

[ICPress](https://icpress.org) is a self-hosted open-source news and content platform consisting of multiple services orchestrated via Docker Compose, including API, site, mail, and event handling backed by MySQL, Redis, Apache Ignite, Gorse (recommendation engine), and OpenStack Swift (object storage).

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- *(Optional)* A Firebase project with an Admin SDK credentials file (`firebase-adminsdk.json`) — required only if you want push notifications on Android when the app is in the background. See [Firebase (Optional)](#firebase-optional) below.

---

## Getting Started

1. Clone this repository.
2. Copy or create your `appsettings.json` in the project root. Optionally add `firebase-adminsdk.json` if you need Android push notifications.
3. Review the configuration sections below and update the relevant values for your environment.
4. Run:

```bash
docker compose up -d
```

---

## Minimum Setup for Development

If you are running the [publicly released Android app](https://play.google.com/store/apps/details?id=net.crowdventures.storypop&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1) from the app store and want to connect it to your own self-hosted backend, only **three things** are required before `docker compose up`:

1. **CDN / Object Storage paths** — update the host IP in `appsettings.json` (see [Section 1](#1-cdn--object-storage-settings) below).
2. **SMTP / Email Server** - Update SMTP server in `appsettings.json` (see [Section 2](#2-smtp--email-configuration) below).
3. **AI / Groq Integration** - Optional but recommended for full Gorse integration and auto-classification of articles. Get your free API key from [groq.com](https://groq.com) and update your key in `appsettings.json` (see [Section 3](#3-ai--groq-api-key) below).
4. **HTTPS reverse proxy** — the [Android app](https://play.google.com/store/apps/details?id=net.crowdventures.storypop&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1) requires HTTPS (Google Play policy). Use [Pinggy](https://pinggy.io) for instant local HTTPS tunnelling (see [HTTPS & Android App Connectivity](#https--android-app-connectivity) below).


Everything else (JWT secret, Keystone auth, Firebase) is only needed for production deployments or when hosting services on separate machines.

---

## Configuration

### 1. CDN / Object Storage Settings

> **Required for development.** Update the host IP before starting the stack.

The platform uses three OpenStack Swift storage buckets, each with a distinct purpose:

| Bucket | Purpose |
|---|---|
| **Small CDN** | Resized miniature/thumbnail images — used for fast preview on the home screen (web and mobile) |
| **Large CDN** | Full-size original images |
| **UserMessage CDN** | Images sent in user-to-user messages |

There are three groups of settings that control how the platform talks to these buckets:

#### `SwiftBucketXXXPath` — Internal upload path (server → Swift)

Used by the backend to upload files directly to the Swift container. This should always point to the Swift service using its **internal Docker network hostname** (`openstack-swift`) unless Swift is exposed on a public DNS:

```json
"SwiftBucketSmallPath":       "http://openstack-swift:8080/v1/AUTH_test/small_cdn",
"SwiftBucketLargePath":       "http://openstack-swift:8080/v1/AUTH_test/large_cdn",
"SwiftBucketUserMessagePath": "http://openstack-swift:8080/v1/AUTH_test/message_cdn"
```

If Swift is running behind a public DNS, replace `openstack-swift:8080` with your public hostname — in that case these will match your `CDNPublishXXXPath` values.

#### `CDNPublishXXXPath` — Direct public path to Swift

The publicly reachable URL for files stored in Swift. This must be the **IP address or DNS name of the host running the containers**, reachable from outside:

```json
"CDNPublishSmallPath":       "http://<your-host-ip>:8080/v1/AUTH_test/small_cdn/",
"CDNPublishLargePath":       "http://<your-host-ip>:8080/v1/AUTH_test/large_cdn/",
"CDNPublishUserMessagePath": "http://<your-host-ip>:8080/v1/AUTH_test/message_cdn/"
```

Replace `192.168.2.150` in the default config with your actual local IP (dev) or public IP/DNS (production).

#### `CDNRequestXXXPath` — Public URL used by clients to fetch files

This is the URL that end users (browsers, mobile apps) use to load images and media. If you have a CDN or caching layer (e.g. Cloudflare, AWS CloudFront) in front of Swift, set this to your CDN domain. Without a CDN layer, set it to the same value as `CDNPublishXXXPath`:

```json
"CDNRequestSmallPath":       "https://cdn.yourdomain.com/small_cdn/",
"CDNRequestLargePath":       "https://cdn.yourdomain.com/large_cdn/",
"CDNRequestUserMessagePath": "https://cdn.yourdomain.com/message_cdn/"
```

**Summary by scenario:**

| Scenario | `SwiftBucketXXXPath` | `CDNPublishXXXPath` | `CDNRequestXXXPath` |
|---|---|---|---|
| Local dev, no CDN | `openstack-swift:8080/...` | `http://192.168.x.x:8080/...` | same as Publish |
| Production, no CDN | `openstack-swift:8080/...` | `https://yourdomain.com/...` | same as Publish |
| Production, with CDN | `openstack-swift:8080/...` | `https://yourdomain.com/...` | `https://cdn.yourdomain.com/...` |
| Swift on public DNS | `https://swift.yourdomain.com/...` | same as Bucket | `https://cdn.yourdomain.com/...` |

### 2. SMTP / Email Configuration

> **Recommended for production.** Without SMTP, user registration emails will not be sent.

Registration and notification emails require a working SMTP server. Update the following keys in `appsettings.json`:

```json
"SMTPServer": "your.smtp.server",
"SMTPPort": 465,
"SMTPUsername": "your-email@example.com",
"SMTPPassword": "your-password"
```

> **Simple option:** Subscribe to [Landermoon](https://landermoon.com) and email **support** — they will promptly provide you with SMTP credentials ready to plug in.

### 3. AI / Groq API Key

> **Optional.** Recommended for Gorse integration and article auto-classification feature.

Set your [Groq](https://groq.com) API key in `appsettings.json`:

```json
"GroqAPIKey": "gsk_your_actual_key"
```

### 4. JWT Secret

> **Required for production.** In development the placeholder works but is not secure.

Replace the placeholder with a strong, randomly generated secret:

```json
"JWTSecret": "your-strong-random-secret-here"
```

### 5. CDN Access Key

> **Required for production.** `CDNAccessKey` must be exactly 16 characters:

```json
"CDNAccessKey": "Your16LengthKey0"
```

### 6. OpenStack Swift (Object Storage)

#### Authentication modes

Swift supports two authentication modes. **Only one should be active at a time.**

**Temp-Auth (development default)**

Works out of the box with the bundled `openstackswift/saio` container — no changes needed for local dev:

```json
"SwiftTempAuthUser": "test:tester",
"SwiftTempAuthKey":  "testing"
```

**Keystone / Application Credentials (production)**

Fill in your application credential ID and secret:

```json
"SwiftKeyStoneAuth": {
  "Auth": {
    "Identity": {
      "ApplicationCredential": {
        "Id":     "your-credential-id",
        "Secret": "your-credential-secret"
      }
    }
  }
}
```

> **Important:** When using Keystone auth you must clear the temp-auth fields to avoid conflicts:
> ```json
> "SwiftTempAuthUser": "",
> "SwiftTempAuthKey":  ""
> ```

### 7. MySQL Passwords

> **Required if running services on separate machines or changing default credentials.**

The MySQL credentials are set in `docker-compose.yml`:

```yaml
environment:
  MYSQL_ROOT_PASSWORD: root_pass
  MYSQL_DATABASE: gorse
  MYSQL_USER: gorse
  MYSQL_PASSWORD: gorse_pass
```

If you change any of these, you must update the matching connection strings in **both** `appsettings.json` and `config.toml` (used by Gorse):

In `appsettings.json`:
```json
"MysqlConnectionGorse":    "Server=mysql;UserId=gorse;Password=<new_pass>;Database=gorse",
"MysqlConnectionStoryPop": "Server=mysql;UserId=gorse;Password=<new_pass>;Database=storypop"
```

In `config.toml`:
```toml
[database]
data_store = "mysql://gorse:<new_pass>@tcp(mysql:3306)/gorse"
```

---

## Database Initialisation

On first startup, MySQL will automatically run any `.sql` files found in the `./mysql_init/` directory. This directory contains the ICPress table schemas for the `storypop` database, which will be created and populated automatically — no manual setup is required.

---

## HTTPS & Android App Connectivity

> **Required for the Android app.** Google Play restricts plain HTTP traffic in production builds, so the API must be reachable over HTTPS.

### Production
Set up a reverse proxy (e.g. [Nginx](https://nginx.org) or [Caddy](https://caddyproject.dev)) in front of the API platform (port `5110`) with a valid TLS certificate from [Let's Encrypt](https://letsencrypt.org).

### Local / Development Testing

[Pinggy](https://pinggy.io) gives you a public HTTPS URL tunnelled to your local machine in a single command — no DNS, no certificates, no configuration:

```bash
ssh -p 443 -R0:LOCALIP:5110 qr@free.pinggy.io
```

Replace `LOCALIP` with the local IP of the machine running the containers (e.g. `192.168.1.10`). Pinggy will print a public HTTPS URL you can paste directly into the app's server settings.

---

## Firebase (Optional)

Firebase is optional. When configured, it enables **offline push notifications on Android** — the app can receive notifications even when it is not running in the foreground.

To enable it:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
2. Generate a service account key (*Project Settings → Service Accounts → Generate new private key*).
3. Save the downloaded JSON as `firebase-adminsdk.json` in the same directory as `docker-compose.yml`.

The file is already referenced in `docker-compose.yml` for the services that need it. If you choose not to use Firebase, simply omit the file — in-app notifications will still work when the app is open.

---

## Services Overview

| Service | Port | Description |
|---|---|---|
| `icpress-apiplatform` | 5110 | Main REST API |
| `icpress-siteplatform` | 5111 | Site / static serving |
| `icpress-mailplatform` | — | Email dispatch service |
| `icpress-eventplatform` | — | Event & push notification service |
| `icpress-spacy` | 5050 | NLP / language processing |
| `gorse-master` | 8086, 8088 | Recommendation engine master |
| `gorse-server` | 8087 | Recommendation API server |
| `gorse-worker` | 8089 | Recommendation engine worker |
| `mysql` | 3306 | Primary database |
| `redis` | 6379 | Cache & message broker |
| `apache-ignite` | 10800 | In-memory data grid |
| `openstack-swift` | 8080 | Object / blob storage |

---

## Data Persistence

Persistent volumes are used for MySQL data, Gorse model data, and logs. On first run, any `.sql` files placed in `./mysql_init/` will be executed automatically against the MySQL instance.

---

## License

This project is licensed under the [GNU Affero General Public License (AGPL)](./LICENSE).
