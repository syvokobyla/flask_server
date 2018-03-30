#!/usr/bin/env python3

import connexion
import flask

from upgrade_server import encoder


def main():
    app = connexion.App(__name__, specification_dir='./swagger/')
    app.app.json_encoder = encoder.JSONEncoder
    app.add_api('swagger.yaml', arguments={'title': 'Upgrade server'})
    app.app.config.from_pyfile('config.cfg')
    app.run(port=8080)


if __name__ == '__main__':
    main()
