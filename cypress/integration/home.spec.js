describe('example to-do app', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/')
  })

  it('displays the intro greeting', () => {
    cy.get('section.title h1').should('have.text', 'The Jungle')
  })
})