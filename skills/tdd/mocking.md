# When to Mock

Mock at **system boundaries** only:

- External APIs (payment, email, etc.)
- Databases (sometimes - prefer test DB)
- Time/randomness
- File system (sometimes)

Don't mock:

- Your own classes/modules
- Internal collaborators
- Anything you control

## Designing for Mockability

At system boundaries, design interfaces that are easy to mock:

**1. Use dependency injection**

Pass external dependencies in rather than creating them internally:

```swift
// Easy to mock
func processPayment(
  order: Order,
  paymentClient: any PaymentClient
) async throws -> PaymentReceipt {
  try await paymentClient.charge(amount: order.total)
}

// Hard to mock
func processPayment(order: Order) async throws -> PaymentReceipt {
  let client = StripeClient(
    apiKey: ProcessInfo.processInfo.environment["STRIPE_KEY"]!
  )
  return try await client.charge(amount: order.total)
}
```

**2. Prefer SDK-style interfaces over generic fetchers**

Create specific functions for each external operation instead of one generic function with conditional logic:

```swift
// GOOD: Each function is independently mockable
protocol APIClient {
  func getUser(id: User.ID) async throws -> User
  func getOrders(userID: User.ID) async throws -> [Order]
  func createOrder(_ input: CreateOrderInput) async throws -> Order
}

// BAD: Mocking requires conditional logic inside the mock
protocol GenericAPIClient {
  func fetch<Response: Decodable>(
    _ type: Response.Type,
    endpoint: String,
    request: URLRequest
  ) async throws -> Response
}
```

The SDK approach means:
- Each mock returns one specific shape
- No conditional logic in test setup
- Easier to see which endpoints a test exercises
- Type safety per endpoint
