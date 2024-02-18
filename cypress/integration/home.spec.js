describe('checking home route', () => {
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
});