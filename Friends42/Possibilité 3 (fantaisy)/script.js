function createMagicParticles() {
  const particlesContainer = document.createElement('div');
  particlesContainer.style.position = 'fixed';
  particlesContainer.style.top = '0';
  particlesContainer.style.left = '0';
  particlesContainer.style.width = '100%';
  particlesContainer.style.height = '100%';
  particlesContainer.style.pointerEvents = 'none';
  particlesContainer.style.zIndex = '9999';
  document.body.appendChild(particlesContainer);

  function createParticle() {
    const particle = document.createElement('div');
    particle.style.position = 'absolute';
    particle.style.width = '7px';
    particle.style.height = '7px';
    particle.style.background = `rgba(${Math.random() * 255}, ${Math.random() * 100 + 155}, 0, 0.7)`;
    particle.style.borderRadius = '50%';
    particle.style.left = Math.random() * 100 + 'vw';
    particle.style.top = Math.random() * 100 + 'vh';
    particle.style.animation = `float ${Math.random() * 5 + 5}s infinite`;
    particlesContainer.appendChild(particle);

    setTimeout(() => particle.remove(), 50000);
  }

  setInterval(createParticle, 250);
}
document.querySelectorAll('.card, .btn, .nav-link, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    el.style.boxShadow = '0 0 20px rgba(232, 185, 35, 0.8)';
  });
  el.addEventListener('mouseleave', () => {
    el.style.boxShadow = 'none';
  });
});
createMagicParticles();
document.addEventListener('mousemove', (e) => {
  const trail = document.createElement('div');
  trail.style.position = 'absolute';
  trail.style.width = '8px';
  trail.style.height = '8px';
  trail.style.background = 'rgba(232, 185, 35, 0.5)';
  trail.style.borderRadius = '50%';
  trail.style.left = `${e.pageX}px`;
  trail.style.top = `${e.pageY}px`;
  trail.style.pointerEvents = 'none';
  document.body.appendChild(trail);
  setTimeout(() => trail.remove(), 250);
});
const style = document.createElement('style');
style.innerHTML = `
  @keyframes float {
    0% { transform: translateY(0); opacity: 0.7; }
    50% { transform: translateY(-20px); opacity: 0.3; }
    100% { transform: translateY(0); opacity: 0; }
  }
`;
document.head.appendChild(style);