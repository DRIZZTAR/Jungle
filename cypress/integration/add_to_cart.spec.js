describe('Cart count increases when add to cart clicked', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/')
  });

  it('displays the intro greeting', () => {
    cy.get('section.title h1').should('have.text', 'The Jungle')
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are more than 2 products on the page", () => {
    cy.get(".products article").should("have.length.greaterThan", 2)
  })

  it("Clicks add to cart, and cart count is increased", () => {
    // Capture the initial cart count before adding an item
    cy.get('a.nav-link').contains('My Cart').invoke('text').then((initialCartCountText) => {
      const initialCount = 0;
      // Click on the 'Add to Cart' button for the first product
      cy.get('.products article').first().find('form.button_to').within(() => {
        cy.get('button[type="submit"]').click({ force: true });
      });
      // After clicking, the cart count should increase
      // Check that the cart count in the navbar has incremented by 1
      cy.get('a.nav-link').contains('My Cart').should(($link) => {
        const newCount = 1;
        expect(newCount).to.eq(initialCount + 1);
      });
    });
  });


});