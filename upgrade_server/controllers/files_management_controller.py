import flask
import connexion
import six
import os

from flask import send_file
from upgrade_server import util


def files_filename_get(filename):  # noqa: E501
    """Gets a file binary

    Returns a single file by filename # noqa: E501

    :param filename: The filename
    :type filename: str

    :rtype: file
    """
    app = flask.current_app
    filepath = os.path.join(app.config['FILES_PATH'], filename)
    resp = send_file(filepath, as_attachment=True)
    return resp


def files_get():  # noqa: E501
    """Gets files list.

    Returns a list containing all files. # noqa: E501


    :rtype: List[str]
    """
    app = flask.current_app
    return os.listdir(app.config['FILES_PATH'])