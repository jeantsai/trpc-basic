import { initTRPC } from "@trpc/server";
import { createHTTPServer } from "@trpc/server/adapters/standalone"

const t = initTRPC.create();
const publicProcedure = t.procedure;

interface User {
    id: string;
    name: string;
}

const users: User[] = [
  {
    id: "1",
    name: "陈建国",
  },
  {
    id: "2",
    name: "张红",
  },
];

const appRouter = t.router({
  userById: publicProcedure
    .input((val: unknown) => {
      if (typeof val === "string") return val;
      throw new Error(`Invalid type of input: ${typeof val}`);
    })
    .query((req) => {
      const { input } = req;
      const user = users.find(u => u.id === input);
      return user;
    })
});

createHTTPServer({
  router: appRouter,
  createContext() {
    return {};
  },
}).listen(3000);


export type AppRouter = typeof appRouter;
