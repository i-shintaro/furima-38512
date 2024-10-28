const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const taxRate = 0.1;
    const taxPrice = Math.floor(inputValue * taxRate);
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = `${taxPrice}`;

    const profit = document.getElementById("profit");
    const profitValue = inputValue - taxPrice;
    profit.innerHTML = `${profitValue}`;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);

