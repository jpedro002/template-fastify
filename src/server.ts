import Fastify from "fastify";

const fastify = Fastify({ logger: true });

const PORT = Number.parseInt(process.env.API_PORT || "3000", 10);

fastify.get("/", async (request, reply) => {
	return { message: "Hello from Fastify with TypeScript! hello" };
});

const start = async () => {
	try {
		await fastify.listen({ port: PORT, host: "0.0.0.0" });
		console.log(`Server listening on http://localhost:${PORT}`);
	} catch (err) {
		fastify.log.error(err);
		process.exit(1);
	}
};

start();
