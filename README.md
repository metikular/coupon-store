# Coupon store

A home for all your coupons and loyalty cards. Free to use at https://coupon.metikular.ch. Self-hostable and open-source (see below).

![Screenshots](doc/coupon-screenshots.png)

## Setup

```shell
docker-compose -f docker-compose.example.yml up
```

### Instance specific configuration

Add a page for data privacy by creating a file at `app/views/pages/data_privacy.html.haml`.

## Development

```shell
bin/setup
bin/dev
```

## Environment variables

- `DEVISE_SENDER_EMAIL`: the email address you are sending emails from

## License

GNU Affero General Public License v3.0
