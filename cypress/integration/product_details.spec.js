describe('Product Details', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('http://127.0.0.1:3000/')
  });

  it('allows navigation from home to product detail page', () => {
    // Check that the home page has loaded by verifying the presence of the intro greeting
    cy.get('section.title h1').should('have.text', 'The Jungle');

    // Check that there are visible products on the page
    cy.get('.products article').should('be.visible');

    // Assuming products are listed and can be clicked to navigate to the detail page
    // Adjust the selector to target a specific product link or button within the `.products article`
    // For example, if each product has a detail link with a class `.details-link`
    cy.get('.products article a').first().click();

    // After clicking, you should be on the product detail page
    // Verify that the product detail page has loaded correctly
    // This could be checking for the presence of a specific element unique to the detail page
    // For example, an element with the product name, description, or an identifier like a class
    cy.url().should('include', '/products/12');

    cy.get('.page-header h1').should('have.text', 'Trees » Cliff Collard');
  });
});