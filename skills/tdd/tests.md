# Good and Bad Tests

## Good Tests

**Integration-style**: Test through real interfaces, not mocks of internal parts.

```swift
// GOOD: Tests observable behavior
@Test("user can checkout with valid cart")
func userCanCheckoutWithValidCart() async throws {
  var cart = Cart()
  cart.add(product)
  let result = try await checkout(cart: cart, paymentMethod: paymentMethod)
  #expect(result.status == .confirmed)
}
```

Characteristics:

- Tests behavior users/callers care about
- Uses public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One logical assertion per test

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```swift
// BAD: Tests implementation details
@Test("checkout calls paymentService.process")
func checkoutCallsPaymentServiceProcess() async throws {
  let mockPayment = MockPaymentService()
  try await checkout(cart: cart, payment: payment, paymentService: mockPayment)
  #expect(mockPayment.processedAmounts == [cart.total])
}
```

Red flags:

- Mocking internal collaborators
- Testing private methods
- Asserting on call counts/order
- Test breaks when refactoring without behavior change
- Test name describes HOW not WHAT
- Verifying through external means instead of interface

```swift
// BAD: Bypasses interface to verify
@Test("createUser saves to database")
func createUserSavesToDatabase() async throws {
  _ = try await createUser(UserInput(name: "Alice"))
  let row = try await database.query(
    "SELECT * FROM users WHERE name = ?",
    bindings: ["Alice"]
  )
  #expect(row != nil)
}

// GOOD: Verifies through interface
@Test("createUser makes user retrievable")
func createUserMakesUserRetrievable() async throws {
  let user = try await createUser(UserInput(name: "Alice"))
  let retrieved = try await getUser(id: user.id)
  #expect(retrieved.name == "Alice")
}
```

**Tautological tests**: Expected value restates the implementation, so the test passes by construction.

```swift
// BAD: Expected value is recomputed the way the code computes it
@Test("calculateTotal sums line items")
func calculateTotalSumsLineItemsTautologically() {
  let items = [LineItem(price: 10), LineItem(price: 5)]
  let expected = items.reduce(0) { sum, item in sum + item.price }
  #expect(calculateTotal(items) == expected)
}

// GOOD: Expected value is an independent, known literal
@Test("calculateTotal sums line items")
func calculateTotalSumsLineItems() {
  #expect(calculateTotal([LineItem(price: 10), LineItem(price: 5)]) == 15)
}
```
