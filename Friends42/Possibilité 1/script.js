const cursor = document.createElement('div');
cursor.className = 'custom-cursor';
document.body.appendChild(cursor);
let particles = [];
const maxParticles = 10;
document.addEventListener('mousemove', (e) => {
    cursor.style.left = e.clientX + 'px';
    cursor.style.top = e.clientY + 'px';
    const particle = document.createElement('div');
    particle.className = 'custom-cursor';
    particle.style.left = e.clientX + 'px';
    particle.style.top = e.clientY + 'px';
    particle.style.opacity = 0.5;
    particle.style.transform = 'scale(0.5)';
    document.body.appendChild(particle);
    particles.push(particle);
    if (particles.length > maxParticles) {
        const oldParticle = particles.shift();
        oldParticle.remove();
    }
    particles.forEach(p => {
        p.style.opacity -= 0.05;
        if (p.style.opacity <= 0) {
            p.remove();
            particles = particles.filter(part => part !== p);
        }
    });
});
setInterval(() => {
    const headers = document.querySelectorAll('h1,h2,h3,h4,.name.display-5.fw-bold,.navbar-brand.me-2.position-relative,.nav-item');
    headers.forEach(h => {
        if (Math.random() < 0.1) {
            h.style.animation = 'glitch 0.5s';
            setTimeout(() => h.style.animation = 'glitch 2s infinite alternate', 500);
        }
    });
}, 3000);
