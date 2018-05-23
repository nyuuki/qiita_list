# from django.urls import reverse
from rest_framework.reverse import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from stocks.models import Stock


class AccountTests(APITestCase):
    url = reverse('stock-list')
    
    def setUp(self):
        print(__name__, "setUP")
        # management.call_command('loaddata', 'fixture.json', verbosity=0)
    
    def test_create_account(self):
        """
        Ensure we can create a new account object.
        """
        data = {'title':'DabApps', "stock_count":3}
        
        response = self.client.post(self.url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Stock.objects.count(), 1)
        self.assertEqual(Stock.objects.get().title, 'DabApps')
    
    def tearDown(self):
        print(__name__, "tearDown")

# class ReadUserTest(APITestCase):
#     def setUp(self):
#         print(__name__, ": setup_class")
#         management.call_command('loaddata', 'fixture.json', verbosity=0)
#
#     def test_can_read_stock_list(self):
#         response = self.client.get(reverse('qiita'))
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#
#     def test_can_read_user_detail(self):
#         response = self.client.get(reverse('qiita', args=[self.stock.id]))
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#
#     def tearDown(self):
#         print(__name__, ": teardown_class")
#         management.call_command('flush', verbosity=0, interactive=False)
