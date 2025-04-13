import asyncio

async def sleep_and_except(s):
    print(f'start sleep and except: {s}')
    await asyncio.sleep(s)
    raise Exception(f'sleep and except: {s}')

async def sleep_and_print(s):
    print(f'start sleep and print: {s}')    
    await asyncio.sleep(s)
    print(f'sleep and print: {s}')

async def main():
    print('main')

    task = asyncio.create_task(sleep_and_print(2))

    await asyncio.sleep(5)
    
    await asyncio.gather(*[
        asyncio.create_task(sleep_and_except(3)),
        task,
        asyncio.create_task(sleep_and_print(4)),
    ])

    print('end main')

if __name__ == '__main__':
    asyncio.run(main())
