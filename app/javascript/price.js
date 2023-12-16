function price (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const itemTax = Math.floor( itemPrice.value * 0.1 );
    const itemProfit = Math.floor( itemPrice.value - itemTax );
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit")
    addTaxPrice.innerHTML = `${itemTax.toLocaleString()}`;
    profit.innerHTML = `${itemProfit.toLocaleString()}`;
  });
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);