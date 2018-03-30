# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from upgrade_server.test import BaseTestCase


class TestFilesManagementController(BaseTestCase):
    """FilesManagementController integration test stubs"""

    def test_files_filename_get(self):
        """Test case for files_filename_get

        Gets a file binary
        """
        response = self.client.open(
            '/upgrade/files/{filename}'.format(filename='filename_example'),
            method='GET')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_files_get(self):
        """Test case for files_get

        Gets files list.
        """
        response = self.client.open(
            '/upgrade/files',
            method='GET')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
