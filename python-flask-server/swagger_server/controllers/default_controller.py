import connexion
import six
import os

from flask import send_file
from swagger_server import util
from flask import current_app as app


def files_filename_get(filename):  # noqa: E501
    """Gets a file binary

    Returns a single file by filename # noqa: E501

    :param filename: The filename
    :type filename: str

    :rtype: file
    """
    filepath = os.path.join(app.config['FILES_PATH'], filename)
    resp = send_file(filepath, as_attachment=True)
    return resp


def files_get():  # noqa: E501
    """Gets files list.

    Returns a list containing all files. # noqa: E501


    :rtype: List[str]
    """
    return os.listdir(app.config['FILES_PATH'])


def version_get():  # noqa: E501
    """Gets api version

    Returns a version of the api. # noqa: E501


    :rtype: str
    """
    return app.config['VERSION']
