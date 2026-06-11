export function logServerError(...details: unknown[]) {
  const timestamp = new Date().toISOString();

  console.error(`[Data/Hora: ${timestamp}]`, ...details);
}
