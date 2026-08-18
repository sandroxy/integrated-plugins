import './styles.css';

const app = document.querySelector<HTMLElement>('#app');

if (!app) {
  throw new Error('Missing #app host element.');
}

app.innerHTML = `
  <section class="empty-state" aria-labelledby="host-title">
    <div class="brand-mark" aria-hidden="true">
      <span></span>
      <span></span>
    </div>
    <h1 id="host-title">Integrated Plugins</h1>
    <p>No packaged plugins installed</p>
  </section>
`;
