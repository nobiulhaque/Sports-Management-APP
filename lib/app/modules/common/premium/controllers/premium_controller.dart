import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/subscription_plan_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class PremiumController extends GetxController {
  final isLoading = true.obs;
  final plans = <PlanData>[].obs;
  final Rxn<PlanData> selectedPlan = Rxn<PlanData>();

  // Card Payment State
  final cardHolderNameController = TextEditingController();
  final isCardComplete = false.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: Replace with your actual Stripe Publishable Key
    Stripe.publishableKey = 'pk_test_51Lx...'; 
    fetchPlans();
  }

  @override
  void onClose() {
    cardHolderNameController.dispose();
    super.onClose();
  }

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      final response = await ApiService().get('/payments/plans');
      
      if (response != null) {
        final model = SubscriptionPlanModel.fromJson(response);
        if (model.success == true && model.data != null) {
          plans.assignAll(model.data!);
          if (plans.isNotEmpty) {
            selectedPlan.value = plans.first;
          }
        }
      }
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(PlanData plan) {
    selectedPlan.value = plan;
  }

  void subscribe() {
    if (selectedPlan.value == null) return;
    
    // Reset inputs
    cardHolderNameController.clear();
    isCardComplete.value = false;
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Card Holder Name
              TextField(
                controller: cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  hintText: 'Ex. John Doe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2B4A8D), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),

              // Stripe Card Field
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: CardField(
                  onCardChanged: (card) {
                    isCardComplete.value = card?.complete ?? false;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Card Information',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 24),

               // Pricing Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total to Pay',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    Text(
                      '\$${selectedPlan.value!.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B4A8D)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Button
              Obx(() => SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: isCardComplete.value ? () {
                    Get.back(); // Close sheet
                    processPayment();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B4A8D),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Secure Checkout', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 16, 
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              )),
              SizedBox(height: MediaQuery.of(Get.context!).viewInsets.bottom + 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  Future<void> processPayment() async {
    try {
      EasyLoading.show(status: 'Processing Payment...');
      
      // 1. Create Payment Method via Stripe with Billing Details
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name: cardHolderNameController.text.trim().isNotEmpty 
                  ? cardHolderNameController.text.trim() 
                  : null,
            ),
          ),
        ),
      );

      // 2. Send PaymentMethod ID to Backend
      final response = await ApiService().post(
        path: '/payments/subscribe',
        data: {
          "planId": selectedPlan.value!.id,
          "paymentMethodId": paymentMethod.id,
        },
      );

      EasyLoading.dismiss();

      if (response != null && response['success'] == true) {
        Get.snackbar(
          'Success!',
          'Your premium subscription has been activated.',
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(20),
          borderRadius: 12,
        );
        // Refresh plans or user profile here if needed
      } else {
        Get.snackbar(
          'Payment Failed',
          response?['message'] ?? 'Subscription could not be processed.',
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
           margin: const EdgeInsets.all(20),
          borderRadius: 12,
        );
      }
    } on StripeException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Stripe Error', 
        e.error.localizedMessage ?? 'An unexpected error occurred.', 
        backgroundColor: Colors.red.shade600, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 12,
      );
    } catch (e) {
      EasyLoading.dismiss();
      print("Payment Error: $e");
      Get.snackbar(
        'Error', 
        'Something went wrong using the payment method.', 
        backgroundColor: Colors.red.shade600, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 12,
      );
    }
  }
}
